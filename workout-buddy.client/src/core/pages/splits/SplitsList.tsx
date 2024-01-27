import { Heading, Stack, Box, GridItem } from "@chakra-ui/react";
import SplitCard from "./SplitCard";
import axios from "axios";
import {useNavigate} from "react-router-dom";
import AuthHeader from "../../../utils/authorizationHeaders";
import SplitsSearchFilters from "./SplitsSearchFilters";
import useColors from "./colors";
import {SmallAddIcon} from "@chakra-ui/icons";
import Wrapper from "../../layouts/ListWrapper";

const SplitsList = () => {
    const colors = useColors();
    const navigate = useNavigate();
    const [splits, setSplits] = useState([]);
    const [exercises, setExercises] = useState([]);

    useEffect(() => {
        const getSplits = async () => {
            const {data} = await axios({
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
                    <GridItem colSpan={3}>
                        <Box
                            style={{
                                justifyContent: "space-between",
                                display: "flex",
                            }}
                        >
                            <Heading>Splits</Heading>

        <Stack>
          {props.splits?.map((split: any) => {
            return <SplitCard key={split.splitId} split={split}></SplitCard>;
          })}
        </Stack>
      </Box>
    </GridItem>
  );
}
