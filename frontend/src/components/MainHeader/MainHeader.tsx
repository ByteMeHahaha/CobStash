import styles from "./MainHeader.module.scss";

type MainHeaderProps = {
  children: React.ReactNode;
};

export function MainHeader({ children }: MainHeaderProps) {
  return (
    <header id="main-header" className={styles.header}>
      <h1>{children}</h1>
    </header>
  );
}
