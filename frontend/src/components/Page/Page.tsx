import { Footer } from "../Footer/Footer";
import { MainHeader } from "../MainHeader/MainHeader";

type PageProps = {
  children: React.ReactNode;
  headerText: string;
};

export function Page({ children, headerText }: PageProps) {
  return (
    <>
      <MainHeader>
        {headerText}
      </MainHeader>
      <main>
        {children}
      </main>
      <Footer />
    </>
  );
}
