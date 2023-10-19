import { useState, useEffect } from "react";
import { Button, Heading, Box, Stack } from "@chakra-ui/react";
import SplitCard from "./SplitCard";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import AuthHeader from "../../../utils/authorizationHeaders";

const SplitsList = () => {
  const navigate = useNavigate();
  const [splits, setSplits] = useState([]);

  useEffect(() => {
    const getExercises = async () => {
      const { data } = await axios({
        method: "get",
        url: "https://localhost:7132/Split/getSplits",
        headers: {
          Authorization: AuthHeader(),
        },
      });
      setSplits(data);
    };
    getExercises();
  }, []);

  const addHandler = () => {
    navigate("/splits/insert-split");
  };

  return (
    <Box m={5} display={"flex"} justifyContent="center" flexDir={"column"}>
      <Box
        style={{
          justifyContent: "space-between",
          display: "flex",
        }}
      >
        <Heading>Splits: </Heading>
        <Button
          colorScheme="blue"
          style={{ backgroundColor: "#d4f0a5" }}
          onClick={addHandler}
        >
          Add new split
        </Button>
      </Box>

      <Stack>
        {splits.map((split: any) => {
          return <SplitCard key={split.splitId} split={split}></SplitCard>;
        })}
      </Stack>
    </Box>
  );
};

export default SplitsList;
