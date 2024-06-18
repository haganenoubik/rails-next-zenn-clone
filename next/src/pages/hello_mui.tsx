import { Button } from '@mui/material'
import { NextPage } from 'next'

const HelloMui: NextPage = () => {
  return (
    <>
      <Button
        variant="contained"
        sx={{
          p: 6,
          ml: 2,
          mt: 3,
          color: { xs: "white", md: "red" },
          textTransform: "none",
        }}
      >
        Hello, MUI
      </Button>
    </>
  );
}

export default HelloMui
