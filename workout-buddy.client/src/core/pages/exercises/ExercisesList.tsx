import {
  Button,
  Heading,
  Box,
  Grid,
} from "@chakra-ui/react";
import axios from "axios";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import AuthHeader from "../../../utils/authorizationHeaders";
import Exercise from "./Exercise";

const ExercisesList = () => {
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
    <Box m={5} display={"flex"} justifyContent="center" flexDir={"column"}>
      <Box
        style={{
          justifyContent: "space-between",
          display: "flex",
        }}
      >
        <Heading>Exercises: </Heading>
        <Button
          colorScheme="blue"
          style={{ backgroundColor: "#d4f0a5" }}
          onClick={addHandler}
        >
          Add new exercise
        </Button>
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
    </Box>
  );
};

export default ExercisesList;
