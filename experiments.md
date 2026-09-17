---
layout: default
title: Experiments
---

# Experiments

Animated GIFs are rendered **offline** from symbolic `.avm.npz` rollouts (glyph + xterm colors), not from terminal screenshots — so they are reproducible and independent of pane size.

## ApplyEyeMakeup POC

![ApplyEyeMakeup rollout](assets/gifs/eye.gif)

Seed class: ApplyEyeMakeup. Model generates continuation after a short context window.

## ApplyLipstick POC

![ApplyLipstick rollout](assets/gifs/lipstick.gif)

Trained separately from eye-makeup (not mixed in the POC stage).

## Merged Apply\* smoke

![Merged Apply smoke rollout](assets/gifs/smoke.gif)

Both makeup classes in one training run. Used for the first multi-clip smoke test.

## Multi-class UCF101-Videos

![Videos-all rollout](assets/gifs/videos_all.gif)

Smoke across the on-disk `UCF101-Videos` dump (beyond Apply\* only), when available.

---

Captions and metrics will be updated as training hardens (best-by-validation checkpoints).
