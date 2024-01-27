import {useState, useEffect} from "react";
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
    Heading, InputGroup, InputLeftAddon, Input, Grid, GridItem,
} from "@chakra-ui/react";
import {HamburgerIcon, CloseIcon, SearchIcon} from "@chakra-ui/icons";
import {useDispatch, useSelector} from "react-redux";
import {accountActions} from "../../store/reducers/account";
import {RootState} from "../../store";
import {ColorModeSwitcher} from "./ColorModeSwitcher";
import useColors from "./colors";

const Links = [
    {text: "Home", path: "/"},
    {text: "Splits", path: "/splits"},
    {text: "Exercises", path: "/exercises"},
    {text: "Calorie Calculator", path: "/calorie-calculator"},
    {text: "My collection", path: "/my-collection"},
];

interface INavLinkProps {
    children: string;
    path: string;
}

const NavLink = ({children, path}: INavLinkProps) => {
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
    const {isOpen, onOpen, onClose} = useDisclosure();
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
                    <Heading _hover={{textDecoration: "none"}}>Workout Buddy</Heading>
                </Flex>
                <Grid gridTemplateColumns={"repeat(12, 1fr);"}
                      px={{md: 8, base: 2}}
                      py={4}
                      bg={"rgba(0, 0, 0, 0.1)"}
                >
                    <GridItem colSpan={4}>
                        <IconButton
                            size={"md"}
                            icon={isOpen ? <CloseIcon/> : <HamburgerIcon/>}
                            aria-label={"Open Menu"}
                            display={{md: "none"}}
                            onClick={isOpen ? onClose : onOpen}
                        />
                        <HStack spacing={8} alignItems={"center"}
                                marginBottom={{base: "10px", xl: 0}}
                                flexBasis={{base: "100%", xl: "0"}} justifyContent={{base: "center", xl: "start"}}>
                            <HStack
                                as={"nav"}
                                spacing={4}
                                display={{base: "none", md: "flex"}}
                                justifyItems="center"
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
                                        href={`http://localhost:3000/pending-exercises?token=${jwtToken}`}
                                    >
                                        Pending Exercises
                                    </Link>
                                )}
                                {isAdmin && (
                                    <Link
                                        px={2}
                                        py={1}
                                        rounded={"md"}
                                        _hover={{
                                            textDecoration: "none",
                                            bg: colors.bgHover,
                                        }}
                                        href={`http://localhost:3000/users-list?token=${jwtToken}`}
                                    >
                                        Users
                                    </Link>
                                )}
                            </HStack>
                        </HStack>
                    </GridItem>

                    <GridItem colSpan={4} width={{ base: "100%", md: "50%", lg: "100%"}} margin={"0 auto"}>
                        <Flex flexBasis="30%">
                            <InputGroup>
                                <InputLeftAddon p={0} children={<Button bg={colors.primaryColor} p={0} borderRadius={0}
                                                                        paddingInline={0}><SearchIcon/></Button>}/>
                                <Input _focusVisible={{borderColor: colors.primaryColor}}
                                       _active={{borderColor: colors.primaryColor}} bg={useColorModeValue("white", "")}
                                       type='text' placeholder='Search keywords: type of exercise'/>
                            </InputGroup>
                        </Flex>
                    </GridItem>

                    <GridItem colSpan={4}>
                        <Flex alignItems={"center"} justifyContent={"end"} flexBasis="30%">
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
                                                    }}
                                                    href={`http://localhost:3000/user-edit?token=${jwtToken}`}
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
                                                    }}
                                                    href={`http://localhost:3000/user-edit?token=${jwtToken}`}
                                                >
                                                    Edit profile
                                                </Link>
                                            </MenuItem>
                                            <MenuItem>
                                                <Link
                                                    px={2}
                                                    py={1}
                                                    rounded={"md"}
                                                    _hover={{
                                                        textDecoration: "none",
                                                    }}
                                                    href={`http://localhost:3000/`}
                                                >
                                                    Change password
                                                </Link>
                                            </MenuItem>
                                            <MenuItem>
                                                <Link
                                                    px={2}
                                                    py={1}
                                                    rounded={"md"}
                                                    _hover={{
                                                        textDecoration: "none",
                                                    }}
                                                    href={`http://localhost:3000/`}
                                                >
                                                    Edit weight
                                                </Link>
                                            </MenuItem>
                                            <MenuDivider/>
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
                                        display={{base: "none", md: "inline-flex"}}
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
                            <ColorModeSwitcher/>
                        </Flex>
                    </GridItem>
                </Grid>

                {isOpen ? (
                    <Box pb={4} display={{md: "none"}}>
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
