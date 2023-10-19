import { Box, HStack, Heading, Image } from "@chakra-ui/react";

interface IDetailsSectionProps {}

const DetailsSection = (props: IDetailsSectionProps) => {
  return (
    <HStack spacing={8} justifyContent="center" textAlign="center" mt={10}>
      <Box>
        <Image
          h="300px"
          src="https://img.freepik.com/free-vector/home-gymnastics-abstract-concept-vector-illustration-stay-active-amid-quarantine-power-training-online-exercise-program-home-workout-social-distance-fitness-livestream-abstract-metaphor_335657-1713.jpg?size=626&ext=jpg&ga=GA1.1.782206126.1697618837&semt=sph"
        />
        <Heading>Text 1</Heading>
      </Box>

      <Box>
        <Image
          h="300px"
          src="https://img.freepik.com/free-vector/happy-smiling-couple-running-summer-park_74855-6517.jpg?size=626&ext=jpg&ga=GA1.1.782206126.1697618837&semt=sph"
        />
        <Heading>Text 1</Heading>
      </Box>

      <Box>
        <Image
          h="300px"
          src="https://img.freepik.com/free-vector/outdoor-workout-training-healthy-lifestyle-open-air-jogging-fitness-activity-male-athlete-running-park-muscular-sportsman-exercising-outdoors-vector-isolated-concept-metaphor-illustration_335657-1338.jpg?size=626&ext=jpg&ga=GA1.1.782206126.1697618837&semt=sph"
        />
        <Heading>Text 1</Heading>
      </Box>
    </HStack>
  );
};

export default DetailsSection;
