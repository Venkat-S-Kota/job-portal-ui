#!/bin/bash
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // "."')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

branch=$(git -C "$dir" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git -C "$dir" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
[ -z "$branch" ] && branch="no git"

pct=${used:-0}
pct=$(printf '%.0f' "$pct")
[ "$pct" -gt 100 ] && pct=100
width=10
filled=$((pct * width / 100))
bar=""
for ((i = 0; i < width; i++)); do
	if [ "$i" -lt "$filled" ]; then bar="${bar}█"; else bar="${bar}░"; fi
done

if [ "$pct" -ge 80 ]; then color='\033[31m'
elif [ "$pct" -ge 50 ]; then color='\033[33m'
else color='\033[32m'; fi

cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
cost=$(printf '%.2f' "$cost")

printf '\033[36m%s\033[0m | %b%s %s%%\033[0m | \033[35m%s\033[0m | \033[33m$%s\033[0m' "$branch" "$color" "$bar" "$pct" "$model" "$cost"
