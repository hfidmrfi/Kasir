<?php

namespace App\Controllers;

class Laporan extends BaseController
{
    public function index(): string
    {
        return view('laporan/data-laporan');
    }
}
