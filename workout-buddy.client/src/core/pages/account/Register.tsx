import {
  Flex,
  Box,
  FormControl,
  FormLabel,
  Input,
  InputGroup,
  HStack,
  InputRightElement,
  Stack,
  Button,
  Heading,
  Text,
  useColorModeValue,
  Link,
} from "@chakra-ui/react";
import { useState } from "react";
import { ViewIcon, ViewOffIcon } from "@chakra-ui/icons";
import { useDispatch } from "react-redux";
import { accountActions } from "../../../store/reducers/account";
import axios from "axios";

const registerModelInitialState = {
  name: "",
  username: "",
  email: "",
  passwordString: "",
  birthDay: "",
  weight: 7,
};

export default function Register() {
  const dispatcher = useDispatch();
  const [registerModel, setRegisterModel] = useState(registerModelInitialState);
  const [showPassword, setShowPassword] = useState(false);

  const submitHandler = async (
    e: React.MouseEvent<HTMLButtonElement, MouseEvent>
  ) => {
    e.preventDefault();
    const res = await axios({
      method: "post",
      url: "http://localhost:8082/UserAccount/register",
      data: registerModel,
    });

    dispatcher(accountActions.register(res.data));

    window.location.href = "/";
  };

  return (
    <Flex
      align={"center"}
      justify={"center"}
      bg={useColorModeValue("white", "gray.800")}
    >
      <Stack spacing={8} mx={"auto"} maxW={"lg"} py={12} px={6}>
        <Stack align={"center"}>
          <Heading fontSize={"4xl"} textAlign={"center"}>
            Sign up
          </Heading>
        </Stack>
        <Box
          rounded={"lg"}
          bg={useColorModeValue("white", "gray.700")}
          boxShadow={"lg"}
          p={8}
          borderColor="lightPallette.primary.main"
          borderWidth="2px"
        >
          <Stack spacing={4}>
            <HStack>
              <Box>
                <FormControl id="firstName" isRequired>
                  <FormLabel>Name</FormLabel>
                  <Input
                    type="text"
                    value={registerModel.name}
                    onChange={(e) =>
                      setRegisterModel({
                        ...registerModel,
                        name: e.target.value,
                      })
                    }
                  />
                </FormControl>
              </Box>
              <Box>
                <FormControl id="lastName" isRequired>
                  <FormLabel>Username</FormLabel>
                  <Input
                    type="text"
                    value={registerModel.username}
                    onChange={(e) =>
                      setRegisterModel({
                        ...registerModel,
                        username: e.target.value,
                      })
                    }
                  />
                </FormControl>
              </Box>
            </HStack>
            <FormControl id="email" isRequired>
              <FormLabel>Email address</FormLabel>
              <Input
                type="email"
                value={registerModel.email}
                onChange={(e) =>
                  setRegisterModel({ ...registerModel, email: e.target.value })
                }
              />
            </FormControl>
            <FormControl id="password" isRequired>
              <FormLabel>Password</FormLabel>
              <InputGroup>
                <Input
                  type={showPassword ? "text" : "password"}
                  value={registerModel.passwordString}
                  onChange={(e) =>
                    setRegisterModel({
                      ...registerModel,
                      passwordString: e.target.value,
                    })
                  }
                />
                <InputRightElement h={"full"}>
                  <Button
                    variant={"ghost"}
                    onClick={() =>
                      setShowPassword((showPassword) => !showPassword)
                    }
                  >
                    {showPassword ? <ViewIcon /> : <ViewOffIcon />}
                  </Button>
                </InputRightElement>
              </InputGroup>
            </FormControl>
            <FormControl id="birthdate" isRequired>
              <FormLabel>Birth Date</FormLabel>
              <Input
                type="datetime-local"
                value={registerModel.birthDay}
                onChange={(e) =>
                  setRegisterModel({
                    ...registerModel,
                    birthDay: e.target.value,
                  })
                }
              ></Input>
            </FormControl>
            <FormControl id="weight" isRequired>
              <FormLabel>Weight</FormLabel>
              <Input
                type="number"
                value={registerModel.weight}
                onChange={(e) =>
                  setRegisterModel({
                    ...registerModel,
                    weight: +e.target.value,
                  })
                }
              ></Input>
            </FormControl>
            <Stack spacing={10} pt={2}>
              <Button
                loadingText="Submitting"
                size="lg"
                colorScheme={useColorModeValue(
                  "lightPallette.primary",
                  "darkPallette.primary"
                )}
                onClick={submitHandler}
              >
                Sign up
              </Button>
            </Stack>
            <Stack pt={6}>
              <Text align={"center"}>
                Already a user?{" "}
                <Link color={"lightPallette.primary.500"} href="/login">
                  Login
                </Link>
              </Text>
            </Stack>
          </Stack>
        </Box>
      </Stack>
    </Flex>
  );
}
