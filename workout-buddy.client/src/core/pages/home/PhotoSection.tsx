import { Box, Heading, Image } from "@chakra-ui/react";

interface IPhotoSection {}

const PhotoSection = (props: IPhotoSection) => {
  return (
    <Box position="relative">
      <Image
        w="100%"
        src="https://img.freepik.com/free-photo/incognito-man-building-biceps-with-barbell_7502-5120.jpg?size=626&ext=jpg&ga=GA1.1.782206126.1697618837&semt=sph"
      />
      <Box zIndex="10" position="absolute" bg="0, 0, 0, 0.3">
        <Heading>Test</Heading>
      </Box>
    </Box>
  );
};

export default PhotoSection;
