import { useCallback, useRef, useState } from "react";
import CodeMirror, { EditorView, ViewUpdate } from "@uiw/react-codemirror";
import { markdown, markdownLanguage } from "@codemirror/lang-markdown";
import FileImporter from "./components/FileImporter";
import FileExporter from "./components/FileExporter";

const theme = EditorView.theme({
  "&": {
    border: "2px solid #edeef1",
    borderRadius: "4px",
  },
  "&.cm-editor.cm-focused": {
    outline: "none",
  },
  "&.cm-editor": {
    height: "100%",
  },
  ".cm-content": {
    height: "100%",
    fontFamily: '"Merriweather Sans", serif',
    padding: "10px 0",
    margin: "0 20px",
    textWrap: "pretty",
    lineHeight: "24px",
  },
  "&.cm-focused": {
    outline: "none",
  },
  ".cm-content li": {
    marginBottom: 0,
  },
  ".cm-activeLine": {
    backgroundColor: "inherit",
  },
  ".cm-comment-thread": {
    backgroundColor: "rgb(255 249 194)",
  },
  ".cm-comment-thread.active": {
    backgroundColor: "rgb(255 227 135)",
  },
  // active highlighting wins if it's inside another thread
  ".cm-comment-thread.active .cm-comment-thread": {
    backgroundColor: "rgb(255 227 135)",
  },
  ".frontmatter": {
    fontFamily: "monospace",
    color: "#666",
    textDecoration: "none",
    fontWeight: "normal",
    lineHeight: "0.8em",
  },
});

export default function App() {
  const [value, setValue] = useState<string>("");
  const [fileName, setFileName] = useState<string>("");
  const fileInputRef = useRef<HTMLInputElement | null>(null);

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const onChange = useCallback((value: string, viewUpdate: ViewUpdate) => {
    setValue(value);
  }, []);

  const handleFileNameChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFileName(e.target.value);
  };

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const handleFile = (file: File) => {
    const reader = new FileReader();

    reader.onloadend = () => {
      if (typeof reader.result === "string") {
        const trimmedFileName = file.name.replace(".md", "");
        setValue(reader.result);
        setFileName(trimmedFileName);
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

    if (fileName != "") {
      a.download = `${fileName}.md`;
    } else if (
      fileInputRef.current &&
      fileInputRef.current.files &&
      fileInputRef.current.files.length > 0
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
            value={fileName}
            onChange={handleFileNameChange}
          />
        </div>
        <div className="flex gap-2">
          <FileImporter handleFile={handleFile} fileInputRef={fileInputRef} />
          <FileExporter handleExport={handleExport} />
        </div>
      </div>

      <div className="mt-5">
        <CodeMirror
          className="w-full bg-white"
          minHeight="200px"
          maxHeight="calc(100vh - 200px)"
          value={value}
          onChange={onChange}
          extensions={[markdown({ base: markdownLanguage }), theme]}
          basicSetup={{
            lineNumbers: false,
            foldGutter: false,
            highlightActiveLineGutter: false,
            highlightActiveLine: false,
          }}
        />
      </div>
    </div>
  );
}
