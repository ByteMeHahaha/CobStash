import { Footer } from "../Footer/Footer";

type PageProps = {
  children: React.ReactNode;
  headerText: string;
};

export function Page({ children, headerText }: PageProps) {
  return (
    <>
      <header>
        <h1>{headerText}</h1>
      </header>
      <main>
        {children}
      </main>
      <Footer />
    </>
  );
}
