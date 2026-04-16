#!/usr/bin/env bash
# Claude Code status line script

input=$(cat)

# --- Extract fields from JSON ---
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
input_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
output_tokens=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
cache_write=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# --- Current directory (shorten home to ~) ---
home="$HOME"
display_cwd="${cwd/#$home/\~}"

# --- Git info ---
git_info=""
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  # Count staged, unstaged, untracked
  staged=$(git -C "$cwd" diff --no-lock-index --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
  unstaged=$(git -C "$cwd" diff --no-lock-index --name-only 2>/dev/null | wc -l | tr -d ' ')
  untracked=$(git -C "$cwd" ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
  status_str=""
  [ "$staged" -gt 0 ]    && status_str="${status_str}+${staged}"
  [ "$unstaged" -gt 0 ]  && status_str="${status_str} ~${unstaged}"
  [ "$untracked" -gt 0 ] && status_str="${status_str} ?${untracked}"
  status_str="${status_str# }"  # trim leading space
  if [ -n "$status_str" ]; then
    git_info="${branch} [${status_str}]"
  else
    git_info="${branch}"
  fi
fi

# --- Context window usage ---
ctx_info=""
if [ -n "$used_pct" ]; then
  total_tokens=$(( input_tokens + output_tokens ))
  ctx_info="$(printf '%.0f' "$used_pct")% (${total_tokens} tkns / ${ctx_size})"
else
  ctx_info="no data"
fi

# --- Session cost ---
cost=$(echo "$input" | jq -r '
  if .context_window.current_usage != null then
    # Rough cost estimate using claude-sonnet pricing (input $3/M, output $15/M, cache-write $3.75/M, cache-read $0.30/M)
    ((.context_window.current_usage.input_tokens // 0) * 3.0 / 1000000) +
    ((.context_window.current_usage.output_tokens // 0) * 15.0 / 1000000) +
    ((.context_window.current_usage.cache_creation_input_tokens // 0) * 3.75 / 1000000) +
    ((.context_window.current_usage.cache_read_input_tokens // 0) * 0.30 / 1000000)
  else
    empty
  end
')

cost_str=""
if [ -n "$cost" ]; then
  cost_str=$(printf '$%.4f' "$cost")
fi

# --- Assemble status line ---
parts=()
parts+=("$display_cwd")
[ -n "$git_info" ] && parts+=("git:${git_info}")
[ -n "$model" ]    && parts+=("$model")
parts+=("ctx:${ctx_info}")
[ -n "$cost_str" ] && parts+=("cost:${cost_str}")

printf '%s' "$(IFS=' | '; echo "${parts[*]}")"
