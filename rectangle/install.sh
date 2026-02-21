#!/bin/bash
# Rectangle config - stored in UserDefaults, cannot be stowed
# Usage: ./install.sh         import settings
#        ./install.sh export   export current settings

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST="$SCRIPT_DIR/Rectangle.plist"

if [ "$1" = "export" ]; then
    defaults export com.knollsoft.Rectangle "$PLIST"
    echo "Exported Rectangle settings to $PLIST"
else
    defaults import com.knollsoft.Rectangle "$PLIST"
    echo "Imported Rectangle settings from $PLIST"
    echo "Restart Rectangle for changes to take effect."
fi
