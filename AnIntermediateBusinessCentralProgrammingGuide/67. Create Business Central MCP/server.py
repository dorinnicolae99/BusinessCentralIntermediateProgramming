import os
from urllib.parse import quote
from uuid import UUID

import httpx
from mcp.server.fastmcp import FastMCP


mcp = FastMCP("My BC Companies")


@mcp.tool()
async def list_companies() -> dict:
    """Read company IDs and names from the configured BC Online environment."""
    required = ("BC_TENANT_ID", "BC_CLIENT_ID", "BC_CLIENT_SECRET", "BC_ENVIRONMENT")
    missing = [name for name in required if not os.environ.get(name)]
    if missing:
        raise ValueError("Missing settings: " + ", ".join(missing))

    # Validate IDs without echoing credentials into errors.
    try:
        tenant = str(UUID(os.environ["BC_TENANT_ID"]))
        client_id = str(UUID(os.environ["BC_CLIENT_ID"]))
    except ValueError:
        raise ValueError("Tenant ID and Client ID must be valid GUIDs.") from None

    environment = os.environ["BC_ENVIRONMENT"]
    token_url = f"https://login.microsoftonline.com/{tenant}/oauth2/v2.0/token"
    companies_url = (
        f"https://api.businesscentral.dynamics.com/v2.0/{tenant}/"
        f"{quote(environment, safe='')}/api/v2.0/companies"
    )

    try:
        async with httpx.AsyncClient(timeout=30) as client:
            token_response = await client.post(
                token_url,
                data={
                    "grant_type": "client_credentials",
                    "client_id": client_id,
                    "client_secret": os.environ["BC_CLIENT_SECRET"],
                    "scope": "https://api.businesscentral.dynamics.com/.default",
                },
            )
            if not token_response.is_success:
                raise ValueError(
                    f"Entra HTTP {token_response.status_code}: check application IDs, "
                    "secret value/expiry, API permission and admin consent."
                )

            token = token_response.json()["access_token"]
            response = await client.get(
                companies_url,
                params={"$select": "id,name", "$top": "100"},
                headers={"Authorization": f"Bearer {token}"},
            )
            if not response.is_success:
                raise ValueError(
                    f"BC HTTP {response.status_code}: check environment name, "
                    "BC application Enabled state and effective API permissions."
                )

            payload = response.json()
            return {
                "environment": environment,
                "companies": [
                    {"id": row["id"], "name": row["name"]}
                    for row in payload["value"]
                ],
                "moreAvailable": bool(payload.get("@odata.nextLink")),
            }
    except httpx.RequestError:
        raise ValueError(
            "Network request failed: check Docker DNS, VPN and connectivity."
        ) from None


if __name__ == "__main__":
    mcp.run(transport="stdio")