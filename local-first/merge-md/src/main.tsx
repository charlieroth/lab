import React from 'react'
import ReactDOM from 'react-dom/client'
import { DocHandle, isValidAutomergeUrl, Repo } from '@automerge/automerge-repo'
import { BroadcastChannelNetworkAdapter } from '@automerge/automerge-repo-network-broadcastchannel'
import { IndexedDBStorageAdapter } from "@automerge/automerge-repo-storage-indexeddb"
import { RepoContext } from '@automerge/automerge-repo-react-hooks'
import './index.css'
import App from './App.tsx'
import { MarkdownDoc } from './types.ts'

const repo = new Repo({
  network: [new BroadcastChannelNetworkAdapter()],
  storage: new IndexedDBStorageAdapter()
})

const rootDocUrl = `${document.location.hash.substring(1) || 'local'}`
let handle: DocHandle<MarkdownDoc>
if (isValidAutomergeUrl(rootDocUrl)) {
  handle = repo.find(rootDocUrl)
} else {
  handle = repo.create<MarkdownDoc>()
  handle.change(d => {
    d.title = 'Untitled'
    d.contents = ''
  })
}
const docUrl = handle.url
document.location.hash = handle.url

// @ts-expect-error - Use later for experimentation
window.handle = handle

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <RepoContext.Provider value={repo}>
      <App docUrl={docUrl} />
    </RepoContext.Provider>
  </React.StrictMode>,
)
