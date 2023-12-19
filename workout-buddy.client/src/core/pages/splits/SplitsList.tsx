import { Heading, Stack, Box, GridItem } from "@chakra-ui/react";
import SplitCard from "./SplitCard";

export default function SplitsList(props: any) {
  return (
    <GridItem colSpan={3}>
      <Box>
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
