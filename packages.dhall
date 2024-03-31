let upstream-ps =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.15-20240320/packages.dhall
        sha256:ae8a25645e81ff979beb397a21e5d272fae7c9ebdb021a96b1b431388c8f3c34

let upstream-lua =
      https://github.com/Unisay/purescript-lua-package-sets/releases/download/psc-0.15.15-20240340/packages.dhall
        sha256:568bf80d1213c70632a2f95f1c318ec237bf2f12f5ce69341145287fde9524a8

in  upstream-ps // upstream-lua
