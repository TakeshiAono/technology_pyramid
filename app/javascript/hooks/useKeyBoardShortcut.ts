import { useEffect } from "react"

type KeyActionMap = {
  "Ctrl+Shift+S"?: (() => void);
}

const useKeyBoardShortcut = (keyActionObject: KeyActionMap) => {
  useEffect(() => {
    validSaveShortCutKey()
    return () => {
      invalidSaveShortCutKey()
    }
  }, [keyActionObject])

  const pressedKeys = [];

  const clearPressedKeys = (e: KeyboardEvent) => {
    pressedKeys.push(e.key);
    pressedKeys.splice(0)
  }

  const pushPressedKeys = (e: KeyboardEvent) => {
    pressedKeys.push(e.key);
    // e.preventDefault()をするとテキスト入力時に削除ができなくなるなどの影響があるため使用しない
    if (pressedKeys.includes("Control")) {
      if (pressedKeys.includes("Shift")) {
        if (pressedKeys.includes("S")) {
          // chromのページ保存機能とかぶるためCtrl + Shift + Sにしている
          keyActionObject["Ctrl+Shift+S"]()
        }
      }
    }
  }

  const validSaveShortCutKey = () => {
    document.addEventListener("keydown", pushPressedKeys);
    document.addEventListener("keyup", clearPressedKeys);
  }

  const invalidSaveShortCutKey = () => {
    document.removeEventListener("keydown", pushPressedKeys);
    document.removeEventListener("keyup", clearPressedKeys);
  }
}

export default useKeyBoardShortcut
