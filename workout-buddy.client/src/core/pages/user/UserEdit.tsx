import React, { useEffect, useState } from "react";
import {
  Button,
  Container,
  Heading,
  Spinner,
  FormControl,
  Input,
  FormLabel,
  Stack,
} from "@chakra-ui/react";
import axios from "axios";
import AuthHeader from "../../../utils/authorizationHeaders";

import "react-datepicker/dist/react-datepicker.css";
import { useNavigate } from "react-router-dom";
import { useDispatch } from "react-redux";
import { accountActions } from "../../../store/reducers/account";

const EditUserPage = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [user, setUser] = useState({
    name: "",
    username: "",
    email: "",
    birthDate: "",
    roles: [],
    currentWeight: 0,
  });

  const navigate = useNavigate();
  const dispatch = useDispatch();

  useEffect(() => {
    const getUserData = async () => {
      try {
        const { data } = await axios.get(
          "http://localhost:8082/UserAccount/profilePage",
          {
            headers: {
              Authorization: AuthHeader(),
            },
          }
        );
        setUser({ ...data });
      } catch (e) {
        console.log(e);
      }
    };
    getUserData();
  }, []);

  const handleSubmit = async (e: any) => {
    e.preventDefault();
    setLoading(true);
    try {
      await axios.post(
        "http://localhost:8082/UserAccount/editProfile",
        {
          username: user.username,
          name: user.name,
          email: user.email,
          birthDate: user.birthDate,
        },
        {
          headers: {
            Authorization: AuthHeader(),
          },
        }
      );
      sessionStorage.setItem("username", user.username);
      dispatch(accountActions.setUser({ username: user.username }));
      navigate("/");
    } catch (e: any) {
      setError(e.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <>
      {loading && <Spinner />}
      <Container maxWidth="md" style={{ marginTop: "40px" }}>
        <Heading
          sx={{
            textTransform: "uppercase",
            margin: "80px 0 40px",
            textAlign: "center",
          }}
          variant="h3"
        >
          Edit your profile
        </Heading>
        <Stack
          as="form"
          spacing={4}
          style={{ display: "flex", flexDirection: "column" }}
          noValidate
          onSubmit={handleSubmit}
        >
          <FormControl>
            <FormLabel>Name</FormLabel>
            <Input
              variant="outlined"
              margin="normal"
              required
              id="name"
              name="name"
              autoComplete="name"
              autoFocus
              value={user.name}
              onChange={(e) =>
                setUser((prevState) => ({ ...prevState, name: e.target.value }))
              }
            />
          </FormControl>
          <FormControl>
            <FormLabel>Username</FormLabel>
            <Input
              variant="outlined"
              margin="normal"
              required
              id="username"
              name="username"
              autoComplete="username"
              value={user.username}
              onChange={(e) =>
                setUser((prevState) => ({
                  ...prevState,
                  username: e.target.value,
                }))
              }
            />
          </FormControl>
          <FormControl>
            <FormLabel>Email</FormLabel>
            <Input
              variant="outlined"
              margin="normal"
              required
              id="email"
              name="email"
              autoComplete="email"
              value={user.email}
              onChange={(e) =>
                setUser((prevState) => ({
                  ...prevState,
                  email: e.target.value,
                }))
              }
            />
          </FormControl>
          <FormControl id="birthdate" isRequired>
            <FormLabel>Birth Date</FormLabel>
            <Input
              type="datetime-local"
              value={user.birthDate}
              onChange={(e) =>
                setUser({
                  ...user,
                  birthDate: e.target.value,
                })
              }
            ></Input>
          </FormControl>
          <FormControl>
            <FormLabel>Weight</FormLabel>
            <Input
              data-testid="user-weight"
              variant="outlined"
              margin="normal"
              id="weight"
              name="weight"
              autoComplete="weight"
              type="number"
              disabled
              value={user.currentWeight}
            />
          </FormControl>
          <FormControl>
            <FormLabel>Roles</FormLabel>
            <Input
              data-testid="user-roles"
              variant="outlined"
              id="roles"
              name="roles"
              autoComplete="roles"
              value={user.roles.join(", ")}
              disabled
            />
          </FormControl>
          <Button
            sx={{ margin: "20px auto" }}
            type="submit"
            colorScheme={"lightPallette.primary"}
          >
            Save
          </Button>
        </Stack>
      </Container>
    </>
  );
};

export default EditUserPage;
