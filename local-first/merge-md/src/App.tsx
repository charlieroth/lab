import { useCallback, useRef, useState } from "react";
import CodeMirror, { ViewUpdate } from "@uiw/react-codemirror";
import { markdown, markdownLanguage } from "@codemirror/lang-markdown";
import FileImporter from "./components/FileImporter";
import FileExporter from "./components/FileExporter";

export default function App() {
  const [value, setValue] = useState<string>("");
  const fileInputRef = useRef<HTMLInputElement | null>(null);

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const onChange = useCallback((value: string, viewUpdate: ViewUpdate) => {
    setValue(value);
  }, []);

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const handleFile = (file: File) => {
    const reader = new FileReader();

    reader.onloadend = () => {
      if (typeof reader.result === "string") {
        setValue(reader.result);
      }
    };

    reader.readAsText(file);
  };

  const handleExport = () => {
    const valueWithPreservedLineBreaks = value.replace(/\r\n/g, "\n");
    const blob = new Blob([valueWithPreservedLineBreaks], {
      type: "text/plain",
    });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.style.display = "none";
    a.target = "_blank";
    a.href = url;

    if (
      fileInputRef.current &&
      fileInputRef.current.files &&
      fileInputRef.current.files[0]
    ) {
      a.download = fileInputRef.current.files[0].name;
    } else {
      a.download = "Untitled.md";
    }

    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    window.URL.revokeObjectURL(url);
  };

  return (
    <div className="container m-auto">
      <div className="flex border-b-2 border-b-black">
        <h1 className="text-3xl">
          <span className="font-semibold">Merge.md</span> - Local First Markdown
          Editing
        </h1>
      </div>
      <div className="mt-5 flex gap-2">
        <FileImporter handleFile={handleFile} fileInputRef={fileInputRef} />
        <FileExporter handleExport={handleExport} />
      </div>
      <div className="mt-5">
        {fileInputRef.current &&
          fileInputRef.current.files &&
          fileInputRef.current.files.length > 0 && (
            <code className="text-md bg-gray-100 p-2 rounded-md">
              {fileInputRef.current.files[0].name}
            </code>
          )}
      </div>
      <div className="mt-5">
        <CodeMirror
          value={value}
          height="auto"
          minHeight="500px"
          width="auto"
          basicSetup={{
            lineNumbers: false,
            foldGutter: false,
            highlightActiveLineGutter: false,
          }}
          extensions={[markdown({ base: markdownLanguage })]}
          onChange={onChange}
        />
      </div>
    </div>
  );
}
