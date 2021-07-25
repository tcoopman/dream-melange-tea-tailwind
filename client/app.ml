(* This line opens the Tea.App modules into the current scope for Program access functions and types *)
open Tea.App

(* This opens the Elm-style virtual-dom functions and types into the current scope *)
open Tea.Html

(* Let's create a new type here to be our main message type that is passed around *)
type msg =
  | Increment (* This will be our message to increment the counter *)
  | Decrement (* This will be our message to decrement the counter *)
  | Reset (* This will be our message to reset the counter to 0 *)
  | Set of int (* This will be our message to set the counter to a specific value *)
[@@bs.deriving { accessors }]
(* This is a nice quality-of-life addon from Bucklescript, it will generate function names for each constructor name, optional, but nice to cut down on code, this is unused in this example but good to have regardless *)

(* This is optional for such a simple example, but it is good to have an `init` function to define your initial model default values, the model for Counter is just an integer *)
let init () = 4

(* This is the central message handler, it takes the model as the first argument *)
let update model = function
  (* These should be simple enough to be self-explanatory, mutate the model based on the message, easy to read and follow *)
  | Increment ->
      model + 1
  | Decrement ->
      model - 1
  | Reset ->
      0
  | Set v ->
      v


(* This is just a helper function for the view, a simple function that returns a button based on some argument *)
let view_button title msg = button [ onClick msg ] [ text title ]

(* This is the main callback to generate the virtual-dom.
   This returns a virtual-dom node that becomes the view, only changes from call-to-call are set on the real DOM for efficiency, this is also only called once per frame even with many messages sent in within that frame, otherwise does nothing *)
let check_mark_icon =
  Tea.Svg.svg
    [ Tea.Svg.Attributes.class' "flex-shrink-0 h-5 w-5 text-cyan-500"
    ; Tea.Svg.Attributes.fill "currentColor"
    ; Tea.Svg.Attributes.viewBox "0 0 20 20"
    ]
    [ Tea.Svg.path
        [ Tea.Svg.Attributes.clipRule "evenodd"
        ; Tea.Svg.Attributes.d
            "M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
        ; Tea.Svg.Attributes.fillRule "evenodd"
        ]
        []
    ]


let view model =
  div
    [ class' "min-h-screen bg-gray-100 py-6" ]
    [ span [ style "text-weight" "bold" ] [ text (string_of_int model) ]
    ; br []
    ; Tea.Svg.svg
        [ Tea.Svg.Attributes.class' "h-5 w-5 text-indigo-500 group-hover:text-indigo-400" ]
        [ Tea.Svg.path
            [ Tea.Svg.Attributes.clipRule "evenodd"
            ; Tea.Svg.Attributes.d
                "M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z"
            ; Tea.Svg.Attributes.fillRule "evenodd"
            ]
            []
        ]
    ; view_button "Increment" Increment
    ; br []
    ; view_button "Decrement" Decrement
    ; br []
    ; view_button "Set to 42" (Set 42)
    ; br []
    ; div
        []
        [ div
            [ class'
                "min-h-screen bg-blue-100 bg-gray-100 py-6 flex flex-col justify-center sm:py-12"
            ]
            [ div
                [ class' "relative py-3 sm:max-w-xl sm:mx-auto" ]
                [ div
                    [ class'
                        "absolute inset-0 bg-gradient-to-r from-cyan-400 to-sky-500 shadow-lg transform -skew-y-6 sm:skew-y-0 sm:-rotate-6 sm:rounded-3xl"
                    ]
                    []
                ; div
                    [ class' "relative px-4 py-10 bg-white shadow-lg sm:rounded-3xl sm:p-20" ]
                    [ div
                        [ class' "max-w-md mx-auto" ]
                        [ div
                            []
                            [ img [ class' "h-7 sm:h-8"; src "/img/logo.svg" ] []; text "        " ]
                        ; div
                            [ class' "divide-y divide-gray-200" ]
                            [ div
                                [ class'
                                    "py-8 text-base leading-6 space-y-4 text-gray-700 sm:text-lg sm:leading-7"
                                ]
                                [ p
                                    []
                                    [ text
                                        "A simple example with dream"
                                    ]
                                ; ul
                                    [ class' "list-disc space-y-2" ]
                                    [ li
                                        [ class' "flex items-start" ]
                                        [ span
                                            [ class' "h-6 flex items-center sm:h-7" ]
                                            [ check_mark_icon ]
                                        ; p
                                            [ class' "ml-2" ]
                                            [ text "Customizing your"
                                            ; code
                                                [ class' "text-sm font-bold text-gray-900" ]
                                                [ text "tailwind.config.js" ]
                                            ; text "file"
                                            ]
                                        ]
                                    ; li
                                        [ class' "flex items-start" ]
                                        [ span
                                            [ class' "h-6 flex items-center sm:h-7" ]
                                            [ check_mark_icon ]
                                        ; p
                                            [ class' "ml-2" ]
                                            [ text "Extracting class'es with                  "
                                            ; code
                                                [ class' "text-sm font-bold text-gray-900" ]
                                                [ text "@apply" ]
                                            ]
                                        ]
                                    ; li
                                        [ class' "flex items-start" ]
                                        [ span
                                            [ class' "h-6 flex items-center sm:h-7" ]
                                            [ (* Tea.Svg.svg [ class' "flex-shrink-0 h-5 w-5 text-cyan-500"; fill "currentColor"; viewBox "0 0 20 20" ] *)
                                              (* [ path [ attribute "clip-rule" "evenodd"; d "M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"; attribute "fill-rule" "evenodd" ] *)
                                              (*       [] *)
                                              (*   ] *) ]
                                        ; p
                                            [ class' "ml-2" ]
                                            [ text "Code completion with instant preview" ]
                                        ]
                                    ]
                                ; p
                                    []
                                    [ text
                                        "Perfect for learning how the framework works, prototyping a new idea, or creating a demo to share online."
                                    ]
                                ]
                            ; div
                                [ class'
                                    "pt-6 text-base leading-6 font-bold sm:text-lg sm:leading-7"
                                ]
                                [ p [] [ text "Want to dig deeper into Tailwind?" ]
                                ; p
                                    []
                                    [ a
                                        [ class' "text-cyan-600 hover:text-cyan-700"
                                        ; href "https://tailwindcss.com/docs"
                                        ]
                                        [ text "Read the docs → " ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ; (if model <> 0 then view_button "Reset" Reset else noNode)
    ]


(* This is the main function, it can be named anything you want but `main` is traditional.
   The Program returned here has a set of callbacks that can easily be called from
   Bucklescript or from javascript for running this main attached to an element,
   or even to pass a message into the event loop.  You can even expose the
   constructors to the messages to javascript via the above [@@bs.deriving {accessors}]
   attribute on the `msg` type or manually, that way even javascript can use it safely. *)
let main =
  beginnerProgram
    { (* The beginnerProgram just takes a set model state and the update and view functions *)
      model = init ()
    ; (* Since model is a set value here, we call our init function to generate that value *)
      update
    ; view
    }
