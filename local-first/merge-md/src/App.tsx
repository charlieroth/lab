import { useCallback, useRef } from "react";
import CodeMirror, { ViewUpdate } from "@uiw/react-codemirror";
import { markdown, markdownLanguage } from "@codemirror/lang-markdown";
import { editorTheme } from "./theme";
import FileImporter from "./components/FileImporter";
import FileExporter from "./components/FileExporter";
import { AutomergeUrl } from "@automerge/automerge-repo";
import { useDocument } from "@automerge/automerge-repo-react-hooks";
import { MarkdownDoc } from "./types";

type AppProps = {
  docUrl: AutomergeUrl;
}

export default function App({ docUrl }: AppProps) {
  const [doc, changeDoc] = useDocument<MarkdownDoc>(docUrl);
  const fileInputRef = useRef<HTMLInputElement | null>(null);

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const onChange = useCallback((value: string, viewUpdate: ViewUpdate) => {
    changeDoc((doc) => doc.contents = value);
  }, []);

  const handleFileNameChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    changeDoc((doc) => doc.title = e.target.value);
  };

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const handleFile = (file: File) => {
    const reader = new FileReader();

    reader.onloadend = () => {
      if (typeof reader.result === "string") {
        const trimmedFileName = file.name.replace(".md", "");
        changeDoc((doc) => {
          doc.contents = reader.result as string
          doc.title = trimmedFileName
        });
      }
    };

    reader.readAsText(file);
  };

  const handleExport = () => {
    if (!doc) {
      return;
    }

    const valueWithPreservedLineBreaks = doc.contents.replace(/\r\n/g, "\n");
    const blob = new Blob([valueWithPreservedLineBreaks], {
      type: "text/markdown",
    });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.style.display = "none";
    a.target = "_blank";
    a.href = url;

    if (doc.title != "") {
      a.download = `${doc.title}.md`;
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
            value={doc?.title || ""}
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
          value={doc?.contents || ""}
          onChange={onChange}
          extensions={[markdown({ base: markdownLanguage }), editorTheme]}
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
