import { Heading, Box, Stack, GridItem } from "@chakra-ui/react";
import SplitCard from "./SplitCard";
import Wrapper from "../../layouts/ListWrapper";

const SplitsList = (props: any) => {
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
        </Box>

        <Stack>
          {props.splits?.map((split: any) => {
            return <SplitCard key={split.splitId} split={split}></SplitCard>;
          })}
        </Stack>
      </GridItem>
    </Wrapper>
  );
};

export default SplitsList;
