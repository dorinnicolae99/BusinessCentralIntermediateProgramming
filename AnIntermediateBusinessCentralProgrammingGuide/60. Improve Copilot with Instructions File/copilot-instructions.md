# GitHub Copilot Instructions for AL Language (Business Central)

These are the coding conventions and rules to follow when generating AL code:

## Naming Conventions
- Use PascalCase for procedure, function, and method names.
- Use camelCase for local variables.
- Always name the current record variable as `Rec`.
- Prefix parameters with `Par` (e.g., `ParCustomer`, `ParItemNo`).

## Documentation Standards
- Every procedure must have an XML documentation comment above it.
- Comments should include: `<summary>`, `<param>`, and `<returns>` tags.

## Code Structure
- Use clear separation of logic inside procedures.
- Avoid nesting more than 2 levels deep.
- Use events/subscribers instead of modifying base application code.

## Formatting
- Use 4-space indentation.
- Maximum line length: 120 characters.
- Align `begin` and `end` properly.
- Use empty lines to separate logical blocks.

## AL Object Guidelines
- Pages should use `PageType = List` or `Card` as appropriate.
- Reports must be named clearly and include caption.
- Use ToolTips on fields and actions.

## Best Practices
- Use TryFunction for operations that can fail.
- Validate all inputs before use.
- Avoid using hardcoded values.
- Use enums instead of options when possible.

## Code Analyzer Compliance
- Code must pass AppSourceCop, CodeCop, and PerTenantExtensionCop without errors. 