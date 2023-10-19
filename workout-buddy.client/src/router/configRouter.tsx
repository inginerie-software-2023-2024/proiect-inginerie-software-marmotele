import { createBrowserRouter } from "react-router-dom";
import GeneralLayout from "../core/layouts/GeneralLayout";
import Login from "../core/pages/account/Login";
import Register from "../core/pages/account/Register";
import PrivateRoute from "../core/components/PrivateRoute";
import MainPage from "../core/pages/home/MainPage";
import ExercisesLayout from "../core/pages/exercises/ExerciseLayout";
import ExercisesList from "../core/pages/exercises/ExercisesList";
import InsertExercise from "../core/pages/exercises/InsertExercise";
import ViewExercise from "../core/pages/exercises/ViewExercise";

export default function configRouter(opts?: string) {
  return createBrowserRouter([
    {
      path: "/",
      element: <GeneralLayout />,
      children: [
        {
          path: "/",
          element: <MainPage />,
        },
        {
          path: "login",
          element: <Login />,
        },
        {
          path: "register",
          element: <Register />,
        },
        {
          path: "exercises",
          element: (
            <PrivateRoute>
              <ExercisesLayout />
            </PrivateRoute>
          ),
          children: [
            {
              path: "/exercises",
              element: (
                <PrivateRoute>
                  <ExercisesList />
                </PrivateRoute>
              ),
            },
            {
              path: "/exercises/insert-exercise",
              element: (
                <PrivateRoute>
                  <InsertExercise />
                </PrivateRoute>
              ),
            },
            {
              path: "/exercises/:id",
              element: (
                <PrivateRoute>
                  <ViewExercise />
                </PrivateRoute>
              ),
            },
          ],
        },
        {
          path: "splits",
          element: (
            <PrivateRoute>
              <ExercisesLayout />
            </PrivateRoute>
          ),
          // children: [
          //   {
          //     path: "/splits",
          //     element: (
          //       <PrivateRoute>
          //         <SplitsList />
          //       </PrivateRoute>
          //     ),
          //   },
          //   {
          //     path: "/splits/insert-split",
          //     element: (
          //       <PrivateRoute>
          //         <InsertSplit />
          //       </PrivateRoute>
          //     ),
          //   },
          //   {
          //     path: "/splits/:id",
          //     element: (
          //       <PrivateRoute>
          //         <ViewSplit />
          //       </PrivateRoute>
          //     ),
          //   },
          // ],
        },
      ],
    },
  ]);
}
