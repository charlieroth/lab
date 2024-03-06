import { ChangeEvent, MouseEventHandler, RefObject } from "react";

type FileImporterProps = {
  handleFile: (file: File) => void;
  fileInputRef: RefObject<HTMLInputElement>;
};

export default function FileImporter({
  handleFile,
  fileInputRef,
}: FileImporterProps) {
  const handleClick: MouseEventHandler<HTMLButtonElement> = () => {
    if (fileInputRef && fileInputRef.current) {
      fileInputRef.current.click();
    }
  };

  const handleChange = (event: ChangeEvent<HTMLInputElement>) => {
    if (event.target.files && event.target.files.length > 0) {
      const fileUploaded = event.target.files[0];
      handleFile(fileUploaded);
    }
  };

  return (
    <div className="flex">
      <button
        className="p-2 border-2 border-gray-200 rounded hover:bg-gray-200 transition-colors duration-300 ease-in-out"
        onClick={handleClick}
      >
        Import
      </button>
      <input
        type="file"
        accept=".md"
        onChange={handleChange}
        ref={fileInputRef}
        style={{ display: "none" }}
      />
    </div>
  );
}
