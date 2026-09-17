#!/usr/bin/env bash
# Restore Jekyll on GitHub Pages by removing .nojekyll, then push.
set -euo pipefail
cd /home/decentricity/neurascii.github.io
rm -f .nojekyll
# Ensure config still has minima theme
test -f _config.yml
grep -q 'theme: minima' _config.yml
# GIFs already at assets/gifs/
test -f assets/gifs/eye.gif
test -f assets/gifs/lipstick.gif
test -f assets/gifs/smoke.gif
git add -A
if git diff --cached --quiet; then
  echo "No staged changes (maybe already fixed locally)."
else
  git commit -m "$(cat <<'EOF'
Restore Jekyll so index.md builds to index.html on Pages.

Removing .nojekyll re-enables GitHub Pages Jekyll processing; assets/gifs/ paths stay unchanged.
EOF
)"
fi
git push origin main
echo "COMMIT=$(git rev-parse HEAD)"
# Poll Pages
for i in $(seq 1 36); do
  code=$(curl -s -o /dev/null -w '%{http_code}' https://neurascii.github.io/ || true)
  gif=$(curl -s -o /dev/null -w '%{http_code}' https://neurascii.github.io/assets/gifs/eye.gif || true)
  echo "poll $i: /=$code eye.gif=$gif"
  if [[ "$code" == "200" && "$gif" == "200" ]]; then
    break
  fi
  sleep 5
done
# Voice announce
MSG='Fixed the neurASCII GitHub Pages four oh four.'
python3 -c "
import sys, subprocess
sys.path.insert(0, '/home/decentricity/.local/share/voice-announce')
from voice_announce import gpu_is_idle, speak_with_piper
msg = '''$MSG'''
if gpu_is_idle():
    speak_with_piper(msg)
else:
    subprocess.run(['/home/decentricity/bin/say-alert', msg], check=False)
" || /home/decentricity/bin/say-alert "$MSG" || true
echo DONE
