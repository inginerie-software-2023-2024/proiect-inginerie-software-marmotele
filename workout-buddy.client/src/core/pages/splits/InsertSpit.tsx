import {
  Button,
  Flex,
  FormControl,
  FormLabel,
  Heading,
  Input,
  Stack,
  useColorModeValue,
  Textarea,
  Checkbox,
} from "@chakra-ui/react";
import { useEffect, useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import Workout from "./Workout";
import AuthHeader from "../../../utils/authorizationHeaders";

export interface ISplit {
  splitId: string;
  name: string;
  description: string;
  musclesGroups: [];
  creatorId: string;
  workouts: {
    selectedMuscleGroups: any;
    isDeleted: boolean;
    workoutName: string;
    id: string;
    exercises: {
      value: string;
    }[];
  }[];
  isPrivate: boolean;
}

interface IWorkout {
  id: string;
  workoutName: string;
  exercises: {
    value: string;
  }[];
  selectedMuscleGroups: {}[];
  isDeleted: boolean;
}

const splitInitialState: ISplit = {
  splitId: "",
  name: "",
  description: "",
  musclesGroups: [],
  creatorId: "",
  workouts: [],
  isPrivate: false,
};

const workoutInitialState: IWorkout = {
  id: "",
  workoutName: "",
  exercises: [],
  selectedMuscleGroups: [],
  isDeleted: false,
};

export default function InsertSplit() {
  const navigate = useNavigate();
  const [split, setSplit] = useState(splitInitialState);

  useEffect(() => {
    const params = new URLSearchParams(location.search);
    const id = params?.get("id");

    const getSplit = async () => {
      const { data } = await axios({
        method: "get",
        url: `https://localhost:7132/Split/getInsertModel?id=${
          id ?? "00000000-0000-0000-0000-000000000000"
        }`,
        headers: {
          Authorization: AuthHeader(),
        },
      });
      setSplit(data);
      console.log(data);
    };

    getSplit();
  }, []);

  const newWorkoutHandler = () => {
    const newWorkouts = split.workouts;
    newWorkouts.push(workoutInitialState);
    setSplit({ ...split, workouts: newWorkouts });
  };

  const submitHandler = async (e: any) => {
    e.preventDefault();

    let formData = new FormData();

    let querryString = `?`;

    formData.append("splitId", split.splitId);
    formData.append("name", split.name);
    formData.append("description", split.description);
    formData.append("isPrivate", new Blob([JSON.stringify(split.isPrivate)]));
    let index = 0;
    for (let w of split.workouts) {
      querryString += `&[${index}].id=${w.id}`;
      querryString += `&[${index}].workoutName=${w.workoutName}`;
      querryString += `&[${index}].isDeleted=${w.isDeleted}`;
      let i = 0;
      for (let ex of w.exercises) {
        querryString += `&[${index}].exercises[${i}]=${ex.value}`;
        i++;
      }

      index++;
    }

    try {
      await axios({
        method: "post",
        url: `https://localhost:7132/Split/insertSplit${querryString}`,
        data: formData,
        //   headers: {
        //     Authorization: AuthHeader(),
        //     "Content-Type": "multipart/form-data"
        //   },
      });
      navigate("/splits");
    } catch (err) {
      console.log("treat errs");
    }
  };

  return (
    <Flex
      minH={"100vh"}
      align={"center"}
      justify={"center"}
      bg={useColorModeValue("gray.50", "gray.800")}
    >
      <Stack
        spacing={4}
        w={"full"}
        maxW={"md"}
        bg={useColorModeValue("white", "gray.700")}
        rounded={"xl"}
        boxShadow={"lg"}
        p={6}
        my={12}
      >
        <Heading lineHeight={1.1} fontSize={{ base: "2xl", sm: "3xl" }}>
          Insert Split
        </Heading>
        <FormControl isRequired>
          <FormLabel>Name</FormLabel>
          <Input
            value={split.name}
            onChange={(e) => setSplit({ ...split, name: e.target.value })}
            placeholder="name"
            _placeholder={{ color: "gray.500" }}
            type="text"
          />
        </FormControl>
        <FormControl isRequired>
          <FormLabel>Description</FormLabel>
          <Textarea
            value={split.description}
            onChange={(e) =>
              setSplit({ ...split, description: e.target.value })
            }
            placeholder="description"
            _placeholder={{ color: "gray.500" }}
          />
        </FormControl>
        {split.workouts &&
          split.workouts.map((w, index) => {
            if (!w.isDeleted) {
              return (
                <Workout
                  key={index}
                  index={index}
                  musclesGroups={split.musclesGroups}
                  split={split}
                  setSplit={setSplit}
                />
              );
            }
          })}

        <FormControl>
          <Flex justifyContent="center">
            <Button onClick={newWorkoutHandler}>Add new workout</Button>
          </Flex>
        </FormControl>
        <FormControl>
          <Checkbox
            checked={split.isPrivate}
            onChange={(e) => {
              console.log(e.target.value);
              //   setSplit({ ...split, isPrivate: e.target.value });
            }}
          >
            Is private?{" "}
          </Checkbox>
        </FormControl>
        <Stack spacing={6} direction={["column", "row"]}>
          <Button
            bg={"blue.400"}
            color={"white"}
            w="full"
            _hover={{
              bg: "blue.500",
            }}
            onClick={submitHandler}
          >
            Submit
          </Button>
        </Stack>
      </Stack>
    </Flex>
  );
}
