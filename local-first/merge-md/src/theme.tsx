import { EditorView } from "@uiw/react-codemirror";

export const editorTheme = EditorView.theme({
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
