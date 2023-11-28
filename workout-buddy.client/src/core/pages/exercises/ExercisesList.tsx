import {
  Button,
  Heading,
  Box,
  Grid, GridItem, Stack,
} from "@chakra-ui/react";
import axios from "axios";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import AuthHeader from "../../../utils/authorizationHeaders";
import Exercise from "./Exercise";
import ListWrapper from "../../layouts/ListWrapper";
import {SmallAddIcon} from "@chakra-ui/icons";
import SplitsSearchFilters from "../splits/SplitsSearchFilters";
import useColors from "./useColors";

const ExercisesList = () => {
  const colors = useColors();
  const navigate = useNavigate();
  const [exercises, setExercises] = useState([]);

  useEffect(() => {
    const getExercises = async () => {
      const { data } = await axios.get("https://localhost:7132/Exercises/get", {
        headers: {
          Authorization: AuthHeader(),
        },
      });
      setExercises(data);
    };
    getExercises();
  }, []);

  const addHandler = () => {
    navigate("/exercises/insert-exercise");
  };
  const deleteHandler = (exerciseId: number) => {
    const newExercises = exercises.filter(
      (ex: any) => ex.exerciseId != exerciseId
    );
    setExercises(newExercises);
  };

  return (
    <ListWrapper>

      <GridItem colSpan={3}>
        <Box
            style={{
              justifyContent: "space-between",
              display: "flex",
            }}
        >
          <Heading>Exercises</Heading>

        </Box>

        <Grid templateColumns="repeat(3, 1fr)" gap={6}>
          {exercises.map((ex: any) => {
            return (
                <Exercise
                    key={ex.exerciseId}
                    exercise={ex}
                    deleteHandler={deleteHandler}
                ></Exercise>
            );
          })}
        </Grid>
      </GridItem>
      <GridItem display="flex" flexDirection="column">
        <Button
            marginTop={"68px"}
            colorScheme={colors.primaryScheme}
            variant="outline"
            onClick={addHandler}
        >
          <SmallAddIcon mr={1} h={6} />Add new exercise
        </Button>


        <SplitsSearchFilters isRangeEnabled={false} data={exercises.map((ex: any) => ({ value: ex.exerciseId, label: ex.name }))} selectPlaceholder="Select exercise type" inputPlaceholder="Search by name" />
      </GridItem>

</ListWrapper>
  );
};

export default ExercisesList;
