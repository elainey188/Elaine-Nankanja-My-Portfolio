<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\JobPosting;

class JobPostingController extends Controller
{
    public function index()
    {
        return view('job-post');
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'job_title' => 'required|max:255',
            'company_name' => 'required|max:255',
            'salary' => 'required|max:255',
            'job_description' => 'required',
            'location' => 'required|max:255',
            'industry' => 'required|max:255',
            'job_type' => 'required|max:255',
        ]);

        $jobPosting = new JobPosting;

        $jobPosting->job_title = $request->job_title;
        $jobPosting->company_name = $request->company_name;
        $jobPosting->salary = $request->salary;
        $jobPosting->job_description = $request->job_description;
        $jobPosting->location = $request->location;
        $jobPosting->industry = $request->industry;
        $jobPosting->job_type = $request->job_type;

        $jobPosting->save();

        return response()->json(['success' => true]);
    }
}

