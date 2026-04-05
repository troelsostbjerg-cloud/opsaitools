#!/bin/bash
# Affiliate Link Swap Script
# Usage: ./scripts/swap-affiliate-links.sh <product> <affiliate-url>
# Example: ./scripts/swap-affiliate-links.sh zoho "https://www.zoho.com/inventory/?ref=YOUR_ID"
#
# Products: zoho, cin7, monday, clickup, inflow, sortly, fishbowl

PRODUCT=$1
AFFILIATE_URL=$2

if [ -z "$PRODUCT" ] || [ -z "$AFFILIATE_URL" ]; then
  echo "Usage: ./scripts/swap-affiliate-links.sh <product> <affiliate-url>"
  echo ""
  echo "Products and their current URLs:"
  echo "  zoho      → https://www.zoho.com/inventory/"
  echo "  cin7      → https://www.cin7.com/"
  echo "  monday    → https://www.monday.com/"
  echo "  clickup   → https://www.clickup.com/"
  echo "  inflow    → https://www.inflowinventory.com/"
  echo "  sortly    → https://www.sortly.com/"
  echo "  fishbowl  → https://www.fishbowlinventory.com/"
  exit 1
fi

case $PRODUCT in
  zoho)
    OLD_URL="https://www.zoho.com/inventory/"
    ;;
  cin7)
    OLD_URL="https://www.cin7.com/"
    ;;
  monday)
    OLD_URL="https://www.monday.com/"
    ;;
  clickup)
    OLD_URL="https://www.clickup.com/"
    ;;
  inflow)
    OLD_URL="https://www.inflowinventory.com/"
    ;;
  sortly)
    OLD_URL="https://www.sortly.com/"
    ;;
  fishbowl)
    OLD_URL="https://www.fishbowlinventory.com/"
    ;;
  *)
    echo "Unknown product: $PRODUCT"
    exit 1
    ;;
esac

# Escape URLs for sed
OLD_ESCAPED=$(echo "$OLD_URL" | sed 's/[\/&]/\\&/g')
NEW_ESCAPED=$(echo "$AFFILIATE_URL" | sed 's/[\/&]/\\&/g')

COUNT=$(grep -rl "$OLD_URL" content/posts/*.md | wc -l | tr -d ' ')

if [ "$COUNT" = "0" ]; then
  echo "No files contain $OLD_URL"
  exit 0
fi

grep -rl "$OLD_URL" content/posts/*.md | xargs sed -i '' "s|$OLD_URL|$AFFILIATE_URL|g"

echo "✓ Replaced $OLD_URL → $AFFILIATE_URL in $COUNT file(s)"
echo ""
echo "Files updated:"
grep -rl "$AFFILIATE_URL" content/posts/*.md
echo ""
echo "Run 'git add -A && git commit -m \"Update $PRODUCT affiliate link\" && git push' to deploy"
