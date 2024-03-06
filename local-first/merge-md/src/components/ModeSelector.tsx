import type { Mode } from "../types"

export default function ModeSelector({
  onImportModeClicked,
  onEditorModeClicked,
  selectedMode
}: {
  onImportModeClicked: () => void
  onEditorModeClicked: () => void
  selectedMode: Mode
}) {
  return (
    <div className="mt-4 flex gap-2">
      <div>
        <button
          className={`
            p-1 border-2 border-slate-200 rounded-md
            ${selectedMode === 'import' ? 'bg-slate-200 text-black' : ''}
          `}
          onClick={onImportModeClicked}
        >
          Import
        </button>
      </div>
      <div>
        <button
          className={`
            p-1 border-2 border-slate-200 rounded-md
            ${selectedMode === 'editor' ? 'bg-slate-200 text-black' : ''}
          `}
          onClick={onEditorModeClicked}
        >
          Editor
        </button>
      </div>
    </div>
  )
}