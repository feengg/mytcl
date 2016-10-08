BEGIN{
    prev_time = 0.0
    finish = -1
}
{
    if($1 < prev_time)
        finish = 1

    if(finish < 0)
    {
        printf("%g %g\n", $1, $2)
        prev_time = $1
    }
}
END{

}
