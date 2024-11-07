# Changelog

## 0.0.1

- Initial release of `algorithmic_search` package.
- Added `SearchSheet` widget for single and multi-select search functionality.
- Implemented `SearchSheetController` for managing selected items and notifying listeners.
- Added `SearchSheetType` enum to support `singleSelect` and `multiSelect` modes.
- Configurable properties:
  - `showSelectedItems` to display selected items at the top.
  - Customizable padding, spacing, and run spacing for item layout.
  - `searchCriteria` for filtering items based on search input.
  - `itemBuilder` for defining the appearance of each item.
- Example app included with usage of both single and multi-select modes.
