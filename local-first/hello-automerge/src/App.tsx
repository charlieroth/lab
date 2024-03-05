import "./App.css";
import { AutomergeUrl } from "@automerge/automerge-repo";
import { useDocument } from "@automerge/automerge-repo-react-hooks";
import { next as A } from "@automerge/automerge";

type AppProps = {
  docUrl: AutomergeUrl;
};

type CounterDoc = {
  counter: A.Counter;
};

export default function App({ docUrl }: AppProps) {
  const [doc, changeDoc] = useDocument<CounterDoc>(docUrl);

  const handleIncrementClicked = () => {
    changeDoc((doc) => {
      doc.counter.increment(1);
    });
  };

  const handleDecrementClicked = () => {
    changeDoc((doc) => {
      doc.counter.decrement(1);
    });
  };

  return (
    <>
      <h1>
        Document URL <code>{docUrl}</code>
      </h1>
      <div className="counter-container">
        <button onClick={handleIncrementClicked}>+</button>
        <h3>Count: {doc?.counter.value}</h3>
        <button onClick={handleDecrementClicked}>-</button>
      </div>
    </>
  );
}
