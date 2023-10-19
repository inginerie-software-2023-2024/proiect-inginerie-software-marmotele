import { useState, useEffect } from "react";
import React from "react";
import {
  Box,
  Flex,
  HStack,
  Link,
  IconButton,
  Button,
  Menu,
  MenuButton,
  MenuList,
  MenuItem,
  MenuDivider,
  useDisclosure,
  useColorModeValue,
  Stack,
  Text,
  Heading,
} from "@chakra-ui/react";
import { HamburgerIcon, CloseIcon } from "@chakra-ui/icons";
import { useDispatch, useSelector } from "react-redux";
import { accountActions } from "../../store/reducers/account";
import { RootState } from "../../store";
import { ColorModeSwitcher } from "./ColorModeSwitcher";
import useColors from "./colors";

const Links = [
  { text: "Home", path: "/" },
  { text: "Splits", path: "/splits" },
  { text: "Exercises", path: "/exercises" },
];

interface INavLinkProps {
  children: string;
  path: string;
}

const NavLink = ({ children, path }: INavLinkProps) => {
  return (
    <Link
      px={2}
      py={1}
      rounded={"md"}
      _hover={{
        textDecoration: "none",
        bg: useColorModeValue("gray.200", "gray.700"),
      }}
      href={path}
    >
      {children}
    </Link>
  );
};

export default function Header() {
  const dispatcher = useDispatch();
  const { isOpen, onOpen, onClose } = useDisclosure();
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const accountState = useSelector((state: RootState) => state.account);
  const [username, setUsername] = useState(accountState.username);
  const [isAdmin, setisAdmin] = useState(false);
  const [jwtToken, setJwtToken] = useState("");
  const colors = useColors();

  const logoutHandler = () => {
    dispatcher(accountActions.signOut());
    window.location.href = "/login";
  };

  useEffect(() => {
    const token = sessionStorage.getItem("token");
    if (token) {
      setJwtToken(token);
      setIsLoggedIn(true);
      setUsername(sessionStorage.getItem("username") ?? "User");
      setisAdmin(sessionStorage.getItem("roles")?.includes("Admin") || false);
    } else {
      setIsLoggedIn(false);
    }
  }, [accountState]);

  return (
    <>
      <Box bg={colors.backgroundHeader}>
        <Box textAlign={"center"} bg={colors.primaryColor} py={2}>
          Welcome to the best fitness app!
        </Box>
        <Flex justify={"center"} py={6}>
          <Heading _hover={{ textDecoration: "none" }}>Workout Buddy</Heading>
        </Flex>
        <Flex
          h={16}
          alignItems={"center"}
          justifyContent={"space-between"}
          px={8}
          py={4}
          bg={"rgba(0, 0, 0, 0.1)"}
        >
          <IconButton
            size={"md"}
            icon={isOpen ? <CloseIcon /> : <HamburgerIcon />}
            aria-label={"Open Menu"}
            display={{ md: "none" }}
            onClick={isOpen ? onClose : onOpen}
          />
          <HStack spacing={8} alignItems={"center"}>
            <HStack
              as={"nav"}
              spacing={4}
              display={{ base: "none", md: "flex" }}
            >
              {Links.map((link) => (
                <NavLink key={link.text} path={link.path}>
                  {link.text}
                </NavLink>
              ))}
              {isAdmin && (
                <Link
                  px={2}
                  py={1}
                  rounded={"md"}
                  _hover={{
                    textDecoration: "none",
                    bg: colors.bgHover,
                  }}
                  href={`http://localhost:4200/pending-exercises?token=${jwtToken}`}
                >
                  Pending Exercises
                </Link>
              )}
            </HStack>
          </HStack>

          <Flex alignItems={"center"}>
            {isLoggedIn ? (
              <React.Fragment>
                <Text>Hello, </Text>
                <Menu>
                  <MenuButton
                    as={Button}
                    rounded={"full"}
                    variant={"link"}
                    cursor={"pointer"}
                    minW={0}
                  >
                    <p>{username}</p>
                  </MenuButton>
                  <MenuList>
                    <MenuItem>
                      <Link
                        px={2}
                        py={1}
                        rounded={"md"}
                        _hover={{
                          textDecoration: "none",
                          bg: colors.bgHover,
                        }}
                        href={`http://localhost:4200/user-profile?token=${jwtToken}`}
                      >
                        My profile
                      </Link>
                    </MenuItem>
                    <MenuItem>
                      <Link
                        px={2}
                        py={1}
                        rounded={"md"}
                        _hover={{
                          textDecoration: "none",
                          bg: colors.bgHover,
                        }}
                        href={`http://localhost:4200/edit-profile?token=${jwtToken}`}
                      >
                        Edit profile
                      </Link>
                    </MenuItem>
                    <MenuItem>Change password</MenuItem>
                    <MenuItem>Edit weight</MenuItem>
                    <MenuDivider />
                    <MenuItem onClick={logoutHandler}>Sign Out</MenuItem>
                  </MenuList>
                </Menu>
              </React.Fragment>
            ) : (
              <HStack spacing={3}>
                <Button fontSize={"sm"} fontWeight={400} variant={"link"}>
                  <Link href="/login">Sign In</Link>
                </Button>
                <Button
                  display={{ base: "none", md: "inline-flex" }}
                  fontSize={"sm"}
                  fontWeight={600}
                  colorScheme={colors.primaryScheme}
                >
                  <Link
                    href="/register"
                    _hover={{
                      textDecoration: "none",
                    }}
                  >
                    Sign Up
                  </Link>
                </Button>
              </HStack>
            )}
            <ColorModeSwitcher />
          </Flex>
        </Flex>

        {isOpen ? (
          <Box pb={4} display={{ md: "none" }}>
            <Stack as={"nav"} spacing={4}>
              {Links.map((link) => (
                <NavLink key={link.text} path={link.path}>
                  {link.text}
                </NavLink>
              ))}
              <Link
                px={2}
                py={1}
                rounded={"md"}
                _hover={{
                  textDecoration: "none",
                  bg: colors.bgHover,
                }}
                href={`http://localhost:4200/pending-exercises?token=${jwtToken}`}
              >
                Pending Exercises
              </Link>
            </Stack>
          </Box>
        ) : null}
      </Box>
    </>
  );
}
