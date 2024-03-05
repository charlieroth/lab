import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.tsx";
import "./index.css";
import {
  DocHandle,
  isValidAutomergeUrl,
  Repo,
} from "@automerge/automerge-repo";
import { BroadcastChannelNetworkAdapter } from "@automerge/automerge-repo-network-broadcastchannel";
import { IndexedDBStorageAdapter } from "@automerge/automerge-repo-storage-indexeddb";
import { next as A } from "@automerge/automerge"; //why `next`? See the the "next" section of the conceptual overview
import { RepoContext } from "@automerge/automerge-repo-react-hooks";

const repo = new Repo({
  network: [new BroadcastChannelNetworkAdapter()],
  storage: new IndexedDBStorageAdapter(),
});

const rootDocUrl = `${document.location.hash.substring(1)}`;
let handle: DocHandle<{
  counter?: A.Counter | undefined;
}>;
if (isValidAutomergeUrl(rootDocUrl)) {
  handle = repo.find(rootDocUrl);
} else {
  handle = repo.create<{ counter?: A.Counter }>();
  handle.change((doc) => (doc.counter = new A.Counter()));
}
document.location.hash = handle.url;
const docUrl = handle.url;

// @ts-expect-error - the `window` object does not have a `handle` property
window.handle = handle;

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <RepoContext.Provider value={repo}>
      <App docUrl={docUrl} />
    </RepoContext.Provider>
  </React.StrictMode>
);
