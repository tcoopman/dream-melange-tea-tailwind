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
let view_button ?(warn = false) title msg =
  let className =
    if warn
    then
      "inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-red-600 justify-center hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
    else
      "inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 justify-center hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
  in
  button [ class' className; onClick msg ] [ text title ]


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
  let list_item (text', url) =
    li
      [ class' "flex items-start" ]
      [ span [ class' "h-6 flex items-center sm:h-7" ] [ check_mark_icon ]
      ; p [ class' "ml-2" ] [ a [ href url ] [ text text' ] ]
      ]
  in

  div
    [ class' "min-h-screen bg-blue-100 bg-gray-100 py-6 flex flex-col justify-center sm:py-12" ]
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
                    [ class' "divide-y divide-gray-200" ]
                    [ div
                        [ class'
                            "py-8 text-base leading-6 space-y-4 text-gray-700 sm:text-lg sm:leading-7"
                        ]
                        [ p
                            [ class' "text-3xl text-cyan-900" ]
                            [ text "A simple example repo with" ]
                        ; ul
                            [ class' "list-disc space-y-2" ]
                            (List.map
                               list_item
                               [ ("Dream", "https://github.com/aantron/dream")
                               ; ("Melange", "https://github.com/melange-re/melange")
                               ; ( "Bucklescript-tea"
                                 , "https://github.com/OvermindDL1/bucklescript-tea" )
                               ; ("Esbuild", "https://esbuild.github.io")
                               ; ("Tailwindcss", "https://tailwindcss.com/")
                               ] )
                        ; p [] [ text "And an interactive model..." ]
                        ; div
                            [ class' "flex flex-col gap-4" ]
                            [ span [ style "text-weight" "bold" ] [ text (string_of_int model) ]
                            ; div
                                [ class' "grid grid-cols-4 gap-3" ]
                                [ view_button "Increment" Increment
                                ; view_button "Decrement" Decrement
                                ; view_button "Set to 42" (Set 42)
                                ; ( if model <> 0
                                  then view_button ~warn:true "Reset" Reset
                                  else noNode )
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
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
