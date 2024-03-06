type FileExporterProps = {
  handleExport: () => void;
};

export default function FileExporter({ handleExport }: FileExporterProps) {
  return (
    <button
      className="text-sm p-2 bg-white border-2 border-bordergray rounded hover:bg-black hover:border-black hover:text-white hover:cursor-pointer transition-colors duration-50 ease-in-out"
      onClick={handleExport}
    >
      Export
    </button>
  );
}
