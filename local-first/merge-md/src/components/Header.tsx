import { Doc } from "@automerge/automerge";
import FileExporter from "./FileExporter";
import FileImporter from "./FileImporter";
import type { MarkdownDoc } from "../types";

type HeaderProps = {
  doc: Doc<MarkdownDoc> | undefined;
  fileInputRef: React.RefObject<HTMLInputElement>;
  handleImport: (file: File) => void;
  handleExport: () => void;
  handleFileNameChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
};

export default function Header({
  doc,
  fileInputRef,
  handleImport,
  handleExport,
  handleFileNameChange,
}: HeaderProps) {
  return (
    <>
      <div className="mt-2 flex border-b-2 border-b-black">
        <h1 className="text-3xl">
          <span className="font-semibold">Merge.md</span> - Local First Markdown
          File Editor
        </h1>
      </div>
      <div className="mt-5 flex justify-between">
        <div>
          <label>Name: </label>
          <input
            className="text-sm bg-white border-2 border-bordergray p-2 rounded"
            value={doc?.title || ""}
            onChange={handleFileNameChange}
          />
        </div>
        <div className="flex gap-2">
          <FileImporter
            handleImport={handleImport}
            fileInputRef={fileInputRef}
          />
          <FileExporter handleExport={handleExport} />
        </div>
      </div>
    </>
  );
}
