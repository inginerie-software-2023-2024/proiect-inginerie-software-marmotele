import { useState, useEffect, Suspense, lazy } from "react";
import { Button, GridItem } from "@chakra-ui/react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import AuthHeader from "../../../utils/authorizationHeaders";
import SplitsSearchFilters from "./SplitsSearchFilters";
import useColors from "./colors";
import { SmallAddIcon } from "@chakra-ui/icons";
import Wrapper from "../../layouts/ListWrapper";
import LoadingSplitsList from "./LoadingSplitsList";

const SplitsList = lazy(() => import("./SplitsList"));

const SplitsWrapper = () => {
  const colors = useColors();
  const navigate = useNavigate();
  const [splits, setSplits] = useState([]);
  const [exercises, setExercises] = useState([]);
  const [searchParams, setSearchParams] = useState("");

  useEffect(() => {
    const getSplits = async () => {
      const { data } = await axios({
        method: "get",
        url: "http://localhost:8082/Split/getSplits",
        headers: {
          Authorization: AuthHeader(),
        },
      });
      setSplits(data);
    };
    getSplits();
  }, []);

  useEffect(() => {
    const getExercises = async () => {
      const { data } = await axios.get("http://localhost:8082/Exercises/get", {
        headers: {
          Authorization: AuthHeader(),
        },
      });
      setExercises(data);
    };
    getExercises();
  }, []);

  const addHandler = () => {
    navigate("/splits/insert-split");
  };

  return (
    <Wrapper>
      <Suspense fallback={<LoadingSplitsList />}>
        <SplitsList  />
      </Suspense>
      <GridItem display="flex" flexDirection="column">
        <Button
          marginTop={"68px"}
          colorScheme={colors.primaryScheme}
          variant="outline"
          onClick={addHandler}
        >
          <SmallAddIcon mr={1} h={6} />
          Add new split
        </Button>

        <Button
          marginTop={"10px"}
          colorScheme={colors.primaryScheme}
          onClick={addHandler}
        >
          Search
        </Button>
        <SplitsSearchFilters
          setSearchParams={setSearchParams}
          searchParams={searchParams}
          isRangeEnabled={true}
          data={exercises.map((ex: any) => ({
            value: ex.exerciseId,
            label: ex.name,
          }))}
          inputPlaceholder="Search by name"
          selectPlaceholder="Select exercise"
        />
      </GridItem>
    </Wrapper>
  );
};

export default SplitsWrapper;