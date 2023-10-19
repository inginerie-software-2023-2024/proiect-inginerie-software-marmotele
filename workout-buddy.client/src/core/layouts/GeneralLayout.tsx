import React from "react";
import { Outlet } from "react-router-dom";
import Header from "../../core/components/Header";

interface IGeneralLayoutProps {}

const GeneralLayout = (props: IGeneralLayoutProps) => {
  return (
    <div className="flex">
      <Header />
      <Outlet />
    </div>
  );
};

export default GeneralLayout;
