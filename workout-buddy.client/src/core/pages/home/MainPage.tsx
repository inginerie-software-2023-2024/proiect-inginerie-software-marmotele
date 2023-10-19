import React from "react";
import PhotoSection from "./PhotoSection";
import DetailsSection from "./DetailsSection";
import FooterSection from "./FooterSection";

const MainPage = () => {
  return (
    <React.Fragment>
      <PhotoSection />
      <DetailsSection />
      <FooterSection />
    </React.Fragment>
  );
};

export default MainPage;
