---
name: caption-tooltip
description: Use when creating or adding a Caption in Microsoft AL, including checking and adding the related ToolTip on the same page control, action, or field.
---

# Caption and Tooltip Workflow

Use this workflow whenever the user asks to create or add a caption.

1. Read the relevant AL object and identify the exact page control, action, field, or other element receiving the `Caption`.
2. Check that same element for a `ToolTip` property.
3. If `ToolTip` is missing, add a concise tooltip that explains what the element does or what information it displays. Keep it next to the `Caption` and follow the surrounding AL style.
4. If a `ToolTip` already exists, keep it unless the new caption makes it inaccurate; update it only when needed.
5. Report both the caption and tooltip outcome

Do not treat a caption-only source change as complete when the owning element has no tooltip.
