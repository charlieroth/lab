import { useState } from "react"
import type { Mode } from "./types"
import ModeSelector from "./components/ModeSelector"
import FileDropZone from "./components/FileDropZone"

export default function App() {
  const [mode, setMode] = useState<Mode>('import')

  const handleImportModeClicked = () => {
    setMode('import')
  }

  const handleEditorModeClicked = () => {
    setMode('editor')
  }

  return (
    <div className="container m-auto">
      <div className="flex border-b-2 border-b-black">
        <h1 className="text-3xl"><span className="font-semibold">Merge.md</span> - Local First Markdown Editing</h1>
      </div>

      <ModeSelector
        onImportModeClicked={handleImportModeClicked}
        onEditorModeClicked={handleEditorModeClicked}
        selectedMode={mode}
      />

      <div className="mt-10">
        <FileDropZone />
      </div>
    </div>
  )
}