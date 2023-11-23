import React, { useEffect, useState } from 'react';
import axios from 'axios';
import AuthHeader from "../../../utils/authorizationHeaders";
import {useNavigate} from "react-router-dom";
import {ExerciseCard} from "../../components/ExerciseCard";

function PendingExercises() {
    const [exercises, setExercises] = useState([]);
    const [error, setError] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        const roles = sessionStorage.getItem('roles');
        if (!roles?.includes('Admin')) {
            navigate("/");
        }
    }, []);

    useEffect(() => {
        const getExercises = async () => {
            try {
                const result = await axios.get(
                    'https://localhost:7132/Admin/getPendingExercises',
                    {
                        headers: {
                            Authorization: AuthHeader(),
                        },
                    }
                );
                console.log(result);
                const data = result.data;
                setExercises(data);
            } catch (error: any) {
                setError(error);
            }
        };
        getExercises();
    }, []);

    return (
        <>
            {!error ? (
                <div className="body">
                    {exercises.length > 0 ? (
                        <ul className="pendingCards">
                            {exercises.map((ex: any) => (
                                <ExerciseCard key={ex.id} exercise={ex} />
                            ))}
                        </ul>
                    ) : (
                        <p>No pending exercise</p>
                    )}
                </div>
            ) : (
                <h1>Error</h1>
            )}
        </>
    );
}

export default PendingExercises;