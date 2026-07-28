$ErrorActionPreference = 'Stop'

function Find-WorkspaceRoot {
    param(
        [Parameter(Mandatory = $true)]
        [string]$StartPath
    )

    $currentPath = $StartPath

    while (-not [string]::IsNullOrWhiteSpace($currentPath)) {
        if (Test-Path -LiteralPath (Join-Path $currentPath 'app.json')) {
            return $currentPath
        }

        $parentPath = Split-Path -Parent $currentPath
        if ($parentPath -eq $currentPath) {
            break
        }

        $currentPath = $parentPath
    }

    return $StartPath
}

$workspaceRoot = Find-WorkspaceRoot -StartPath $PSScriptRoot
$supportedProtocolVersion = '2025-06-18'

function Write-McpMessage {
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$Message
    )

    $json = $Message | ConvertTo-Json -Depth 20 -Compress
    [Console]::Out.WriteLine($json)
    [Console]::Out.Flush()
}

function Write-McpError {
    param(
        [Parameter(Mandatory = $true)]
        $Id,
        [Parameter(Mandatory = $true)]
        [int]$Code,
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    Write-McpMessage @{
        jsonrpc = '2.0'
        id = $Id
        error = @{
            code = $Code
            message = $Message
        }
    }
}

function Get-ProjectInfoTool {
    return @{
        name = 'get_al_project_info'
        title = 'Get AL Project Info'
        description = 'Reads app.json and returns the main AL project metadata in simple terms.'
        inputSchema = @{
            type = 'object'
            properties = @{}
            additionalProperties = $false
        }
    }
}

function Invoke-ProjectInfoTool {
    $appJsonPath = Join-Path $workspaceRoot 'app.json'

    if (-not (Test-Path -LiteralPath $appJsonPath)) {
        return @{
            content = @(
                @{
                    type = 'text'
                    text = "Could not find app.json in $workspaceRoot."
                }
            )
            isError = $true
        }
    }

    $app = Get-Content -LiteralPath $appJsonPath -Raw | ConvertFrom-Json
    $ranges = @($app.idRanges | ForEach-Object { "$(($_.from))-$(($_.to))" })
    $summary = @(
        "Project: $($app.name)",
        "Publisher: $($app.publisher)",
        "Version: $($app.version)",
        "Business Central application: $($app.application)",
        "Runtime: $($app.runtime)",
        "Object ID ranges: $($ranges -join ', ')"
    ) -join "`n"

    return @{
        content = @(
            @{
                type = 'text'
                text = $summary
            }
        )
        structuredContent = @{
            name = $app.name
            publisher = $app.publisher
            version = $app.version
            application = $app.application
            runtime = $app.runtime
            idRanges = @($app.idRanges | ForEach-Object {
                @{
                    from = $_.from
                    to = $_.to
                }
            })
        }
        isError = $false
    }
}

while (($line = [Console]::In.ReadLine()) -ne $null) {
    if ([string]::IsNullOrWhiteSpace($line)) {
        continue
    }

    try {
        $message = $line | ConvertFrom-Json
    }
    catch {
        [Console]::Error.WriteLine("Invalid JSON input: $line")
        continue
    }

    $method = $message.method
    $id = $message.id

    switch ($method) {
        'initialize' {
            $requestedVersion = $message.params.protocolVersion
            $protocolVersion = if ($requestedVersion -eq $supportedProtocolVersion) {
                $requestedVersion
            }
            else {
                $supportedProtocolVersion
            }

            Write-McpMessage @{
                jsonrpc = '2.0'
                id = $id
                result = @{
                    protocolVersion = $protocolVersion
                    capabilities = @{
                        tools = @{
                            listChanged = $false
                        }
                    }
                    serverInfo = @{
                        name = 'alProjectInfo'
                        title = 'AL Project Info Server'
                        version = '1.0.0'
                    }
                    instructions = 'Use the get_al_project_info tool when the user asks for app.json metadata or a simple project summary.'
                }
            }
        }
        'notifications/initialized' {
            continue
        }
        'ping' {
            Write-McpMessage @{
                jsonrpc = '2.0'
                id = $id
                result = @{}
            }
        }
        'tools/list' {
            Write-McpMessage @{
                jsonrpc = '2.0'
                id = $id
                result = @{
                    tools = @(
                        (Get-ProjectInfoTool)
                    )
                }
            }
        }
        'tools/call' {
            if ($message.params.name -ne 'get_al_project_info') {
                Write-McpError -Id $id -Code -32602 -Message "Unknown tool: $($message.params.name)"
                continue
            }

            Write-McpMessage @{
                jsonrpc = '2.0'
                id = $id
                result = (Invoke-ProjectInfoTool)
            }
        }
        default {
            if ($null -ne $id) {
                Write-McpError -Id $id -Code -32601 -Message "Method not found: $method"
            }
        }
    }
}