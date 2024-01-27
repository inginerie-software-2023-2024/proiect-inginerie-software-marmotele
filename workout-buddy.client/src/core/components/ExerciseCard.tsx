import { useState } from 'react';
import {
    Card,
    CardHeader,
    CardBody,
    Heading,
    Button,
} from '@chakra-ui/react';
import AuthHeader from "../../utils/authorizationHeaders";
import axios from 'axios';

export const ExerciseCard = ({
    exercise,
}: {
    exercise: any;
}) => {
    const [triggerRemove, setTriggerRemove] = useState(false);

    async function approveHandler() {
        setTriggerRemove(!triggerRemove);
        await axios.post(
            `http://localhost:8082/Exercises/approve`,
            exercise.exerciseId,
            {
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: AuthHeader(),
                },
            }
        );
    }

    async function deleteHandler() {
        setTriggerRemove(!triggerRemove);
        await axios.post(
            `http://localhost:8082/Exercises/reject`,
            exercise.exerciseId,
            {
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: AuthHeader(),
                },
            }
        );
    }

    return (
        <>
            {!triggerRemove && (
                <Card sx={{ maxWidth: 345 }}>
                    <CardHeader
                        as="img"
                        height="140"
                        src={`http://localhost:8082/Image/getImageById?id=${exercise.idImage}`}
                        alt={exercise.name}
                    />
                    <CardBody>
                        <Heading variant="h5" as="div">
                            Name of exercise: {exercise.name}
                        </Heading>
                        <Heading variant="body2" color="text.secondary">
                            Type of exercise: {exercise.exerciseType}
                        </Heading>
                        <div className="btnGroup">
                            <Button
                                variant="contained"
                                color="secondary"
                                onClick={approveHandler}
                            >
                                Accept
                            </Button>
                            <Button
                                variant="contained"
                                color="warning"
                                onClick={deleteHandler}
                            >
                                Delete
                            </Button>
                        </div>
                    </CardBody>
                </Card>
            )}
        </>
    );
};