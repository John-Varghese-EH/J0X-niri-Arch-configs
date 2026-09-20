# Contributing

Thank you for considering contributing to this repository! 

## How to Contribute

1. Fork the repository and clone it to your local machine.
2. Create a new branch for your feature or bug fix.
3. Make your changes.
4. Test your changes locally.
5. Submit a pull request.

## Local Testing

Before submitting a pull request, please make sure your changes pass the configuration validations. You can test your changes locally by running the following commands:

- **Niri Config**: `niri validate -c niri/config.kdl`
- **Keyd Config**: `keyd check keyd/default.conf`
- **Install Script**: `shellcheck install.sh`

## PR Guidelines

- Describe your changes clearly in the pull request description.
- Please test your configurations on actual hardware to ensure they work as intended.
- **Note**: This setup is designed specifically for Niri on Wayland. Pull requests for other compositors are welcome, but they may need to be placed in separate configuration branches to maintain focus and stability.
