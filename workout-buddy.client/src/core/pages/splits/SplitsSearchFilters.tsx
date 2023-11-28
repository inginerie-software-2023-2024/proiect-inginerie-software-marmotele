import Select from "react-select";
import React, {useState} from "react";
import {Box, Button, Input, InputGroup, InputLeftElement, Text} from "@chakra-ui/react";
import useColors from "./colors";
import CustomeSlider from "../../components/CustomeSlider";
import {SearchIcon} from "@chakra-ui/icons";
interface ISplitsSearchFiltersProps {
    data: any
    selectPlaceholder: string
    inputPlaceholder: string
    isRangeEnabled: boolean
}

const SplitsSearchFilters = (props: ISplitsSearchFiltersProps) => {
    const colors = useColors();
    const [searchParams, setSearchParams] = useState({
        input: "",
        min: 0,
        max: 50,
        types: []
    })



    return <Box color={"gray.800"} padding={colors.filtersPadding} bg={"white"} mt={7} borderRadius="4px">
        <Text fontSize="xl" mb={2}>Library</Text>
        {props.data.length > 0 && <Select placeholder={props.selectPlaceholder} isClearable={true} closeMenuOnSelect={false} isMulti={true} options={props.data}/>}
        {props.isRangeEnabled && <CustomeSlider min={0} max={50} stepToNumber={0} stepToIndex={0} stepByNumber={0} defaultValue={[0, 50]}
                       aria-label={["min-rate", "max-rate"]} />}
        <InputGroup mt={6}>
            <InputLeftElement pointerEvents='none'>
                <SearchIcon color='gray.900' />
            </InputLeftElement>
            <Input bg={"darkPallette.accent.100"} _placeholder={{ color: "black" }} placeholder={props.inputPlaceholder} size='md' value={searchParams.input} onChange={e => setSearchParams({ ...searchParams, input: e.target.value })} />
        </InputGroup>

        <Button
            marginTop={"10px"}
            w={"100%"}
            colorScheme={colors.primaryScheme}
        >
            Search
        </Button>
    </Box>
}

export default SplitsSearchFilters;