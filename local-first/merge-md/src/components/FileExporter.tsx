type FileExporterProps = {
  handleExport: () => void;
};

export default function FileExporter({ handleExport }: FileExporterProps) {
  return (
    <button
      className="p-2 border-2 border-gray-200 rounded hover:bg-gray-200 transition-colors duration-300 ease-in-out"
      onClick={handleExport}
    >
      Export
    </button>
  );
}
