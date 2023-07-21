from typing import Optional
import fire
from llama import Llama

#-------------------------------------------------------------------------------

COMMAND_EXIT="exit"

#-------------------------------------------------------------------------------

FLAG_USE_MEMORY=True

#-------------------------------------------------------------------------------

def main(
    ckpt_dir: str,
    tokenizer_path: str,
    temperature: float = 0.6,
    top_p: float = 0.9,
    max_seq_len: int = 512,
    max_batch_size: int = 4,
    max_gen_len: Optional[int] = None,
):
    generator = Llama.build(
        ckpt_dir=ckpt_dir,
        tokenizer_path=tokenizer_path,
        max_seq_len=max_seq_len,
        max_batch_size=max_batch_size,
    )

    print(f"Type '{COMMAND_EXIT}' to exit.")
    dialogs = [[]]

    while True:
        print("Enter prompt: ", end='' )
        prompt = input()
        if prompt.strip() == COMMAND_EXIT:
            break

        # dialogs = [[{"role": "user", "content": f"{prompt}"}]]

        prompt_structure = {"role": "user", "content": f"{prompt}"}

        if FLAG_USE_MEMORY:
            dialogs[0].append({"role": "user", "content": f"{prompt}"})
        else:
            dialogs[0] = [prompt_structure]

        results = generator.chat_completion(
            dialogs,  # type: ignore
            max_gen_len=max_gen_len,
            temperature=temperature,
            top_p=top_p,
        )

        result_structure = results[0]['generation']

        print(f"> {result_structure['role'].capitalize()}: {result_structure['content']}")
        print("\n==================================\n")

        if FLAG_USE_MEMORY:
            dialogs[0].append(result_structure)

        # for dialog, result in zip(dialogs, results):
        #     for msg in dialog:
        #         print(f"{msg['role'].capitalize()}: {msg['content']}\n")
        #     print(
        #         f"> {result['generation']['role'].capitalize()}: {result['generation']['content']}"
        #     )
        #     print("\n==================================\n")

#-------------------------------------------------------------------------------
# Entry point

if __name__ == "__main__":
    fire.Fire(main)
